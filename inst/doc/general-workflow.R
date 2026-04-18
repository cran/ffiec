## ----include = FALSE----------------------------------------------------------
library(ffiec)
no_creds <- no_creds_available()
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = !no_creds
)

## ----eval = no_creds, echo = FALSE, comment = NA------------------------------
# message(
#   "No FFIEC API credentials available. Code chunks will not be evaluated."
# )

## ----load, eval = FALSE-------------------------------------------------------
# library(ffiec)

## ----periods------------------------------------------------------------------
reporting_periods <- get_reporting_periods(as_data_frame = TRUE)

## ----last_four_quarters-------------------------------------------------------
reports_2025 <- reporting_periods |>
  dplyr::filter(
    ReportingPeriod <= as.Date("2025-12-31"),
    ReportingPeriod >= as.Date("2025-01-01")
  ) |>
  dplyr::pull()

## ----call_data----------------------------------------------------------------
call_df <- get_facsimile(
  reporting_period_end_date = reports_2025,
  fi_id = c(480228, 451965)
)

## ----call_data_count----------------------------------------------------------
call_df |>
  dplyr::count(CallDate, BankRSSDIdentifier)

## ----call_data_filter---------------------------------------------------------
call_df |>
  dplyr::filter(MDRM == "RCFA8274") |>  # Tier 1 capital
  dplyr::mutate(Value = as.numeric(Value))

