class AttendancesController < ApplicationController
    def index
        @example_json = {'hello' => 'world'}
        render json: @example_json
    end
end
