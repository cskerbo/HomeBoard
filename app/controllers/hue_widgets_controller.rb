class HueWidgetsController < ApplicationController
  def create
    helpers.create_bridges
  end
end