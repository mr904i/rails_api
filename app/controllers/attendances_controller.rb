class AttendancesController < ApplicationController
    def index
        #自分のレコードだけ表示する
        example_json = {'hello' => 'world'}
        render json: example_json
    end
    #打刻アクション
    def create
        @attendance = Attendance.new(attendance_params)

        # response
        if @attendance.save
            render json: @attendance, status: :created, location: attendances_url
        else
            render json: @attendance.errors, status: :unprocessable_entity
        end
    end

    private
    def attendance_params
        #ユーザーidもこちらに移動する
        attendance_params = params.require(:attendance).permit(:date, :start_time, :end_time)
        user_id = user_authentication
        attendance_params["user_id"] = user_id
        return attendance_params
    end

end
