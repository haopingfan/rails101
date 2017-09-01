module FlashesHelper
  FLASH_CLASS = { alert: 'danger', notice: 'success', warning: 'warning' }.freeze

  def to_bootstrap_class(key)
    FLASH_CLASS[key.to_sym]
  end

  def user_facing_flashes
    flash.select{ |key, _| %w[alert notice warning].include?(key) }
  end
end
