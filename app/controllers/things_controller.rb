# frozen_string_literal: true
class ThingsController < ApplicationController
  def show
    @thing_op = present Thing::Update
    @thing = @thing_op.model

    form Comment::Create, params: params.merge(thing_id: @thing.id)
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

  def create_comment
    @thing_op = present Thing::Update
    @thing = @thing_op.model

    run Comment::Create, params: params.merge(thing_id: params[:id]) do |op|
      return redirect_to thing_path(op.thing)
    end

    render :show
  end
end
