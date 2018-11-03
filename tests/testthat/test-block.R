context("test-block")

library("gistr")
library("vegawidget")

# determines if we have a GITHUB_PAT environment variable
has_github_pat <- (nchar(Sys.getenv("GITHUB_PAT")) > 0)

spec_mtcars <-
  spec_mtcars %>%
  vw_as_json() %>%
  as_vegaspec()

test_that("we can create and retrieve a block", {

  print(substr(Sys.getenv(), 1, 7))

  skip_on_cran()
  skip_if_not(has_github_pat, "GITHUB_PAT not available")

  # create block (gist)
  list_id <- vw_create_block_gistid(spec_mtcars)
  expect_is(list_id, "list")

  skip_if_not(is.list(list_id), "gist not created, will not try to retrieve")

  # retrieve spec from block (gist)
  spec <- vw_retrieve_block(list_id$id)
  expect_identical(spec, spec_mtcars)

  # delete gist
  gistr::delete(list_id$id)
})


