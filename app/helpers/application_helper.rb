# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def interpret( status )
    case status
    when -1
      return 'lost'
    when 0
      return 'pending'
    when 1
      return 'won'
    else
      return 'not sure. status must be -1 or 0 or 1'
    end
  end

  def shorten( attr , len=24)
    attr.length <= len ? attr : attr[0..len] + "... "  
  end#shorten

  def n_a_ify( string )
    string.length.zero? ? %W( NA ) : string
  end
  
  def date_ify( date )
    date.strftime('%m/%d/%Y')
  end
  
  def get_css( controller )
    [controller.controller_name, 'application','tablesort/tablesort.css','humanity/syle.css']
  end
  
  def get_js
    ['jquery.min.js',
      'jquery-ui.min.js',
        'jrails.js',
            'jquery.tablesorter.min.js',
                'application.js']
  end
    
  def default_content_for(name, &block)
    name = name.kind_of?(Symbol) ? ":#{name}" : name
    out = eval("yield #{name}", block.binding)
    concat(out || capture(&block), block.binding)
  end

end
