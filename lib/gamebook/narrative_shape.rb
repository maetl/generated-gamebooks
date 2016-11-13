module Gamebook
  class NarrativeShape
    def branch(graph, previous_node)
      rand(1..5).times do |inc|
        next_node = graph.add_node(label: :star_system)
        graph.add_edge(from: previous_node, to: next_node)
        previous_node = next_node
      end

      previous_node
    end

    def branch_and_bottleneck
      Mementus::Graph.new do
        intro = add_node(label: :interstellar_space)
        branches = []

        rand(1..5).times do
          branches << branch(self, intro)
        end

        next_node = add_node(label: :interstellar_space)

        branches.each do |branch|
          add_edge(from: branch, to: next_node)
        end
      end
    end

    def generate(story_type)
      case story_type
      when :pursuit then branch_and_bottleneck
      when :quest then branch_and_bottleneck
      end
    end
  end
end
