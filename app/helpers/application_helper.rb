module ApplicationHelper
  def present(object, klass=nil)
    klass ||= "#{object.instance_of?(Class) ? object : object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
end
