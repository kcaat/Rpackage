test_that("dummyvar works", {
  expect_equal(typeof(dummyvar(data=randomsurvey,"AreaType")), "list")
})
#dataset is a list object
