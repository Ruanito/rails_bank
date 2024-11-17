class HealthController < ApplicationController
  def check
    db_connected = ActiveRecord::Base.connection.active?

    if db_connected
      render json: { status: "ok", database: "connected" }
    else
      render json: { status: "error" }
    end
  end
end
