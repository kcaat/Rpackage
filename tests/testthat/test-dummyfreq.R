test_that("dummyfreq works", {
  expect_equal(typeof(dummyfreq(data=randomsurvey,"Aspect")), "character")
})
#table1 is a character object
