
# ipinfo

Collect Metadata on ‘IP’ Addresses and Autonomous Systems

## Description

The ‘ipinfo.io’ <https://ipinfo.io/> service provides an ‘API’ for
retrieving metadata on ‘IP’ addresses and autonomous systems. Methods
are provided to query and retrieve this metadata.

## What’s Inside The Tin

The following functions are implemented:

  - `country_trans`: Retrieve a data frame of country abbreviation to
    name mappings
  - `query_asn`: Retrieve full ASN details
  - `query_ip`: Retrieve full IP details

## Installation

``` r
devtools::install_github("hrbrmstr/ipinfo")
```

## Usage

``` r
library(ipinfo)

# current verison
packageVersion("ipinfo")
```

    ## [1] '0.1.0'

### Lookup an IP

``` r
str(
  query_ip("1.1.1.1"),
  1
)
```

    ## List of 8
    ##  $ ip      : chr "1.1.1.1"
    ##  $ hostname: chr "1dot1dot1dot1.cloudflare-dns.com"
    ##  $ city    : chr "Research"
    ##  $ region  : chr "Victoria"
    ##  $ country : chr "AU"
    ##  $ loc     : chr "-37.7000,145.1830"
    ##  $ postal  : chr "3095"
    ##  $ org     : chr "AS13335 Cloudflare, Inc."

### Lookup an ASN

I do not have a paid plan for this so I cannot test it

### Country iso2c to name mapping

``` r
country_trans()
```

    ## # A tibble: 250 x 2
    ##    iso2c country_name          
    ##    <chr> <chr>                 
    ##  1 BD    Bangladesh            
    ##  2 BE    Belgium               
    ##  3 BF    Burkina Faso          
    ##  4 BG    Bulgaria              
    ##  5 BA    Bosnia and Herzegovina
    ##  6 BB    Barbados              
    ##  7 WF    Wallis and Futuna     
    ##  8 BL    Saint Barthelemy      
    ##  9 BM    Bermuda               
    ## 10 BN    Brunei                
    ## # ... with 240 more rows

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
