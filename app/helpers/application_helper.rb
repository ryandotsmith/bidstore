# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  ####################
  #get_css
  def get_css( controller )
    [controller.controller_name, 'application','tablesort/tablesort.css','humanity/syle.css']
  end#get_css
  
  ####################
  #get_js
  def get_js
    ['jquery.min.js',
      'jquery-ui.min.js',
        'jrails.js',
            'jquery.tablesorter.min.js',
                'application.js']
  end#get_js


end
