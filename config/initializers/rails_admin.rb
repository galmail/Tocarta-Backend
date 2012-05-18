# RailsAdmin config file. Generated on March 15, 2012 10:25
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.authorize_with :cancan
  # config.authenticate_with {}


  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Tocarta', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = []

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = []

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  config.models do
    # Configuration here will affect all included models in all scopes, handle with care!
  
    list do
      # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
      exclude_fields :created_at, :updated_at
      
      fields_of_type :date do
        # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
      end

    end
  end
  
  ######## User Model ########
  
  config.model User do
    label 'Usuario'
    label_plural 'Usuarios'
    object_label_method :email
    list do
      exclude_fields :id, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :current_sign_in_ip, :role, :restaurant, :client
    end
    edit do
      exclude_fields :id, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :current_sign_in_ip, :restaurant, :client, :role
    end
  end
  
  ######## Chain Model ########
  
  config.model Chain do
    label 'Cadena'
    label_plural 'Cadenas'
    list do
      exclude_fields :id, :user, :address, :note, :survey_questions
    end
  end
  
  ######## Restaurant Model ########
  
  config.model Restaurant do
    label 'Restaurante'
    label_plural 'Restaurantes'
    list do
      exclude_fields :id, :user, :note, :restaurant_activities, :restaurant_banners, :menus, :combos, :combo_types, :tables, :comments, :restaurant_setting
      field :chain do
        label "Cadena"
      end
    end
  end
  
  ######## RestaurantSetting Model ########
  
  config.model RestaurantSetting do
    label 'Ajustes'
    label_plural 'Ajustes'
    list do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games
    end
    update do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games, :restaurant
      field :num_licenses do
        read_only true
      end
    end
    create do
      exclude_fields :id, :default_language, :last_menu_sync, :multilang_homepage, :games
    end
  end
  
  ######## Menu Model ########
  
  config.model Menu do
    label 'Menu'
    label_plural 'Menus'
    list do
      exclude_fields :id, :theme, :menu_setting, :sections
    end
  end
  
  ######## MenuSetting Model ########
  
  config.model MenuSetting do
    label 'Menu Setting'
    label_plural 'Menu Settings'
    list do
      exclude_fields :id, :priority, :trigger_activation, :last_time_changed
    end
    edit do
      exclude_fields :id, :priority, :trigger_activation, :last_time_changed
    end
  end
  
  ######## DishType Model ########
  
  config.model DishType do
    label 'Tipo de Comida'
    label_plural 'Tipos de Comida'
    list do
      exclude_fields :id, :position, :dish_class, :dish_type_associations, :dishes
    end
  end
  
  ######## Dish Model ########
  
  config.model Dish do
    label 'Plato'
    label_plural 'Platos'
    list do
      exclude_fields :id, :combo, :description, :reviews, :story, :video, :nutrition_facts, :photo
      exclude_fields :badge_name, :short_title, :order_items, :comments, :dish_variations, :dish_type_associations, :dish_types, :dish_section_associations, :dish_subsection_associations
    end
    edit do
      exclude_fields :id, :combo, :reviews, :story, :video, :nutrition_facts
      exclude_fields :order_items, :comments, :dish_variations, :dish_type_associations, :dish_section_associations, :dish_subsection_associations
      field :rating do
        read_only true
      end
    end
  end
  
  ######## Section Model ########
  
  config.model Section do
    label 'Seccion'
    label_plural 'Secciones'
    object_label_method do
      :section_label_method
    end
    list do
      exclude_fields :id, :menu, :hasBigSubsections, :subsections, :dishes, :dish_section_associations
    end
    edit do
      exclude_fields :subsections, :dishes, :dish_section_associations
    end
  end
  
  ######## Subsection Model ########
  
  config.model Subsection do
    label 'Subseccion'
    label_plural 'Subsecciones'
    list do
      exclude_fields :id, :dishes, :dish_subsection_associations
    end
    edit do
      exclude_fields :id, :dishes, :dish_subsection_associations
    end
  end
  
  ######## Comment Model ########
  
  config.model Comment do
    label 'Comentario'
    label_plural 'Comentarios'
    list do
      include_fields :created_at, :rating, :description, :name, :dish, :survey_question, :approved, :restaurant
      exclude_fields :id, :client
      field :created_at do
        label "Fecha y Hora"
      end
      field :rating do
        label "Estrellas"
      end
      field :description do
        label "Comentario"
      end
      field :name do
        label "Nombre del Cliente"
      end
      field :dish do
        label "Plato"
      end
      field :survey_question do
        label "Pregunta de Satisfaccion"
      end
      field :restaurant do
        label "Restaurante"
      end
      field :approved do
        label "Aprobado"
      end
    end
    edit do
      include_fields :created_at, :rating, :description, :name, :dish, :survey_question, :approved, :restaurant
      exclude_fields :id, :client
      field :created_at do
        label "Fecha y Hora"
        read_only true
      end
      field :rating do
        label "Estrellas"
        read_only true
      end
      field :description do
        label "Comentario"
        read_only true
      end
      field :name do
        label "Nombre del Cliente"
        read_only true
      end
      field :dish do
        label "Plato"
        read_only true
      end
      field :survey_question do
        label "Pregunta de Satisfaccion"
        read_only true
      end
      field :restaurant do
        label "Restaurante"
        read_only true
      end
      field :approved do
        label "Aprobado"
      end
    end
  end
  
  ######## Table Model ########
  
  config.model Table do
    label 'Mesa'
    label_plural 'Mesas'
    object_label_method do
      :table_label_method
    end
    list do
      exclude_fields :id, :name, :language, :orders, :restaurant_activities
      include_fields :updated_at
      field :updated_at do
        label 'Last Activity'
      end
      sort_by :updated_at
    end
    show do
      exclude_fields :id, :name, :language, :orders, :restaurant_activities
      include_fields :updated_at
      field :updated_at do
        label 'Last Activity'
      end
    end
    create do
      exclude_fields :id, :name, :language, :status, :dinners, :tablets, :orders, :restaurant_activities
    end
  end
  
  ######## Tablet Model ########
  
  config.model Tablet do
    label 'Tablet'
    label_plural 'Tablets'
    list do
      exclude_fields :id, :orders, :activated, :access_key, :display_size, :device_brand, :device_name, :device_os, :alive
    end
    show do
      exclude_fields :id, :alive, :orders
    end
  end
  
  ######## SurveyQuestion Model ########
  
  config.model SurveyQuestion do
    label 'Pregunta de Satisfaccion'
    label_plural 'Preguntas de Satisfaccion'
    list do
      exclude_fields :id, :chain, :comments
      sort_by :position
    end
    edit do
      exclude_fields :id, :comments
    end
  end
  
  ######## Order Model ########
  
  config.model Order do
    label 'Pedido'
    label_plural 'Pedidos'
    object_label_method do
      :order_label_method
    end
    list do
      exclude_fields :tablet, :client, :restaurant_activities, :name, :note, :language
      include_fields :created_at
      field :created_at do
        label "Fecha y Hora"
      end
      field :order_items do
        label "Articulos"
      end
      field :table do
        label "Mesa"
      end
    end
    show do
      exclude_fields :client, :restaurant_activities, :name, :note, :language
      include_fields :created_at, :total
    end
  end
  
  ######## OrderItem Model ########
  
  config.model OrderItem do
    object_label_method do
      :order_item_label_method
    end
  end
  
  def order_item_label_method
    "#{self.quantity.to_s} #{self.name}"
  end
  
  def order_label_method
    "#{self.id.to_s}"
  end
  
  def table_label_method
    "#{self.number.to_s}"
  end
  
  def section_label_method
    if self.menu.nil?
      "#{self.name.to_s}"
    else
      "#{self.name.to_s} - #{self.menu.name.to_s}"
    end 
  end
  
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

end
