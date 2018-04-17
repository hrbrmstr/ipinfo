#' Retrieve full IP details
#'
#' @md
#' @param ip IP address to query for
#' @param token Your <ipinfo.io> access token. A token is not required for the
#'        free tier but is required to gain access to any extra fields that
#'        you subscribed to.
#' @note Free usage of our API is limited to 1,000 API requests per day.
#' @references <https://ipinfo.io/developers#full-ip-details>
#' @export
query_ip <- function(ip, token = Sys.getenv("IPINFOIO_TOKEN", unset = "")) {

  httr::GET(
    url = sprintf("%s://ipinfo.io", if (token[1] == "") "http" else "https"),
    path = sprintf("/%s/json", ip),
    query = list(
      token = token[1]
    )
  ) -> res

  if (httr::status_code(res) == 429) stop("Daily rate limit exceeded", call.=FALSE)

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")

  res <- jsonlite::fromJSON(res)

  res

}

#' Retrieve full ASN details
#'
#' @md
#' @param asn AS number to query for. The `AS` prefix will be provided if not present
#' @param token Your <ipinfo.io> access token. A token is  required for the ASN API.
#' @references <https://ipinfo.io/developers/asn>
#' @export
query_asn <- function(asn, token = Sys.getenv("IPINFOIO_TOKEN", unset = "")) {

  if (token[1] == "") stop("An ipinfo.io token is required to use the ASN API", call.=FALSE)

  asn <- toupper(asn[1])
  if (!grepl("^AS", asn)) sprintf("AS%s", asn)

  httr::GET(
    url = "https://ipinfo.io",
    path = sprintf("/%s/json", asn),
    query = list(
      token = token[1]
    )
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")

  res <- jsonlite::fromJSON(res)

  res

}


#' Retrieve a data frame of country abbreviation to name mappings
#'
#' Provided by <country.io>
#'
#' @md
#' @note Consider caching this information. While our world is, indeed, in turmoil
#'       countries do not disappear _that_ quickly.
#' @export
country_trans <- function() {

  x <- jsonlite::fromJSON("http://country.io/names.json")

  data.frame(
    iso2c = names(x),
    country_name = unlist(x, use.names = FALSE),
    stringsAsFactors = FALSE
  ) -> xdf

  class(xdf) <- c("tbl_df", "tbl", "data.frame")

  xdf

}
