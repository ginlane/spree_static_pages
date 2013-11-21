Deface::Override.new(virtual_path: "spree/admin/shared/_configuration_menu",
                     name: "add_static_pages_link",
                     insert_bottom: "[data-hook=admin_configurations_sidebar_menu]",
                     text: <<-EOS
<%= configurations_sidebar_menu_item Spree.t(:static_pages), admin_static_pages_path %>
EOS
  )
