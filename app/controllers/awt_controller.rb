class AwtController < ApplicationController
  def index
    @class_list = CLASS_LIST
    @awt = get_awt_with_runners
  end
end
