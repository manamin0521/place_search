class PlaceListsController < ApplicationController
  def index
    @place = PlaceList.new
  end
end
