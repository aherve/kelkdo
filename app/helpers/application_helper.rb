module ApplicationHelper

  def title(arg)
    s = "Kelkdo"
    s << " | #{arg}" unless arg.empty?
    s
  end

end
