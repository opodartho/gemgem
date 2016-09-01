# frozen_string_literal: true
class ThingsController < ApplicationController
  def show
    present Thing::Update
  end

  def new
    form Thing::Create
  end

  def edit
    form Thing::Update

    render action: :new
  end

  def create
    run Thing::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end
end
