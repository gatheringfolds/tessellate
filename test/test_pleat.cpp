#include <catch2/catch.hpp>
#include <tessellate/pleat.hpp>

#include <iostream>

TEST_CASE("Test pleat", "[pleat]")
{
   h2d::Point2d p{1, 2};
   std::cout << p << std::endl;
   REQUIRE(true);
}
