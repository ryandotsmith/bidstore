module BidsHelper

  def add_lane_link(form_builder, name )
    link_to_function name do |page|
      page.insert_html :bottom, :lanes, :partial => 'lanes/lane',
                                        :locals  => {:f => form_builder }
    end
  end

end

