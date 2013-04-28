require "rails_erd/diagram"

class YumlDiagram < RailsERD::Diagram
  setup { @edges = [] }

  # Invoked once for each relationship
  each_relationship do |relationship|
    line = if relationship.indirect? then "-.-" else "-" end

    arrow = case
    when relationship.one_to_one?   then "1#{line}1>"
    when relationship.one_to_many?  then "1#{line}*>"
    when relationship.many_to_many? then "*#{line}*>"
    end

    @edges << "[#{relationship.source}] #{arrow} [#{relationship.destination}]" unless relationship.destination.to_s.include? "::Translation"
    
  end

  # Should save or return the generated diagram
  save { @edges * "<br/>" }
end
