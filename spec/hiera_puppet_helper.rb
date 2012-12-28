module HieraHelper

  public
  def use_config(hiera_config)
    @hiera = Hiera.new(:config => hiera_config)
  end

end
