class HomePageController < ApplicationController
  def home
    @tours = Tour.name_sort.limit Settings.tour.limit_list
    @newest_tours = Tour.available.newest_tour.limit Settings.tour.limit_list
    @recommended_tours = Tour.recommended_tour.limit Settings.tour.recommended_limit
  end
end
