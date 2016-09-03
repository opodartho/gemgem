Kaminari::Helpers::Paginator.class_eval do
  def render(&block)
    instance_eval(&block) if @options[:total_pages] > 1
  end
end
