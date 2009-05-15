module BidsHelper

  def add_lane_link(form_builder, name )
    link_to_function name do |page|
      page.insert_html :bottom, :lanes, :partial => 'lanes/lane',
                                        :locals  => {:f => form_builder, :lane => Lane.prep }
    end
  end

  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end

  def add_object_link(name, form, object, partial, where)
      #options = { :parent => true }.merge(options)
      html = render(:partial => partial, :locals => { :f => form }, :lane => object)
      link_to_function name, %{
        var new_object_id = new Date().getTime() ;
        var html = jQuery(#{js html}.replace(/index_to_replace_with_js/g, new_object_id));
        html.appendTo(jQuery("#{where}"));
      }
  end



end

