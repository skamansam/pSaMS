class RequestFormat
  def initialize(params)
    @params = params.symbolize_keys
    @format = @params[:format].to_s
  end

  def method_missing(method_name, *args)
    method_name.to_s == @format || method_name.to_s == @format+'?'
  end
end