class UmlController < ApplicationController
  
  def index
    
  end
  
  def generate
    @yuml_code = YumlDiagram.create
  end
  
end
