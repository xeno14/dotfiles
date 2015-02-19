#include <gtest/gtest.h>

#include "<+TEST TARGET+>.h"

class SomeTest : public ::testing::Test {
 protected:
  virtual void SetUp() {

  }

  virtual void TearDown() {

  }
};

TEST_F(SomeTest, test1) {
  <+CURSOR+>
}
