#pragma once

#include <homog2d.hpp>
#include <type_traits>

namespace tsl {

struct MountainTag
{
};
struct ValleyTag
{
};

template <typename T>
concept is_fold_tag = std::is_same_v<MountainTag, T> or std::is_same_v<ValleyTag, T>;

template <is_fold_tag T>
struct Fold
{
   using fold_type = T;

   Fold() = default;
   ~Fold() = default;

   Fold(Fold&&) noexcept = default;
   Fold(Fold const&) = default;
   Fold& operator=(Fold&&) noexcept = default;
   Fold& operator=(Fold const&) = default;

   template <typename... Ts>
   explicit Fold(Ts&&... ts) : segment(std::forward<decltype(ts)>(ts)...)
   {}
   h2d::Segment segment;
};

template <is_fold_tag T>
auto operator==(Fold<T> const& lhs, Fold<T> const& rhs) -> bool
{
   lhs.segment == rhs.segment;
}

template <typename T>
concept is_fold = std::is_same_v<MountainTag, T> or std::is_same_v<ValleyTag, T>;

using Mountain = Fold<MountainTag>;
using Valley = Fold<ValleyTag>;

} // namespace tsl