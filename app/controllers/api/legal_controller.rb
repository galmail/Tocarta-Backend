class Api::LegalController < AccessController
  
  # Returns the Agreement
  def index
    validate_params(['rol','locale','title'])
    @rol = params[:rol]
    @locale = params[:locale]
    @title = params[:title] 
    agreement = Agreement.find(:first,:conditions => {:rol => @rol, :locale => I18n.locale, :title => @title})
    if !agreement.nil?
      render :layout => false, :text => agreement.content
    else
      render :nothing => true
    end
  end
  
end
