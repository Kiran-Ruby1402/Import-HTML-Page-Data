class CitiesController < ApplicationController

	def index
		@cities = City.order(:name)
	end
end
