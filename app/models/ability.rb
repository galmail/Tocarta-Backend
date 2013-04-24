class Ability
  include CanCan::Ability

  def initialize(user)
    
    
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
    
    #cannot [:update, :destroy], User, :email => 'username@example.com' #testing
    
    alias_action :update, :destroy, :create, :to => :write
    
    if user.role == "admin"
      can :manage, :all
      can :update_tablet, :all
      cannot :import, :all
      can :import, [Dish]
    elsif user.role == "restaurant"
      can :read, DishType
      can :read, Theme
      can :read, Skin
      can :read, Chain, :user_id => user.id
      can :read, Restaurant, :chain => { :user_id => user.id }
      can [:read, :update], RestaurantSetting, :restaurant => { :chain_id => user.chain.id  }
      can :read, Menu, :restaurant => { :chain_id => user.chain.id  }
      can [:read, :update], MenuSetting, :menu => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can [:read, :update, :create], Section, :menu => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can [:read, :update, :create], Subsection, :section => { :menu_id => user.chain.restaurants.collect{ |res| res.menus.collect{ |menu| menu.id }}.flatten }
      can [:read, :update, :create], Dish, :chain => { :user_id => user.id }
      can :manage, NutritionFact, :dish => { :chain_id => user.chain.id }
      can [:read, :update], Comment, :restaurant => { :chain_id => user.chain.id  }
      can [:read, :create], Table, :restaurant => { :chain_id => user.chain.id  }
      can :read, Tablet, :table => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can :read, SurveyQuestion, :chain => { :user_id => user.id }
      can :read, Order, :table => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      cannot :import, :all
    elsif user.role == "distributor"
      can :read, DishType
      can :read, Theme
      can :read, Skin
      can [:update, :create], Skin, :user_id => user.id
      can [:read, :update], Chain, :user_id => user.id
      can :manage, Restaurant, :chain => { :user_id => user.id }
      can :manage, RestaurantSetting, :restaurant => { :chain_id => user.chain.id  }
      can :manage, RestaurantBanner, :restaurant => { :chain_id => user.chain.id  }
      can :manage, Menu, :restaurant => { :chain_id => user.chain.id  }
      can :manage, MenuSetting, :menu => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can :manage, Section, :menu => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can :manage, Subsection, :section => { :menu_id => user.chain.restaurants.collect{ |res| res.menus.collect{ |menu| menu.id }}.flatten }
      can :manage, Dish, :chain => { :user_id => user.id }
      can :manage, NutritionFact, :dish => { :chain_id => user.chain.id }
      can [:read, :update], Comment, :restaurant => { :chain_id => user.chain.id  }
      can :manage, Table, :restaurant => { :chain_id => user.chain.id  }
      can :manage, Tablet, :table => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      can :manage, SurveyQuestion, :chain => { :user_id => user.id }
      can :read, Order, :table => { :restaurant_id => user.chain.restaurants.collect{ |res| res.id }.flatten }
      cannot :import, :all
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
