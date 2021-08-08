#pragma once

#include <homog2d.hpp>

namespace tsl {
class Pleat{
 public:
   Pleat(h2d::Line2d mountain, double distance) { }

private:
   h2d::Line2d mountain{};
   h2d::Line2d valley{};
};
}