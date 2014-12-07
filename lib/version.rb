module Version
  #PSAMS_VERSION = '0.5'
  #GIT_BRANCH    = 'develop'
  #GIT_HASH      = '00000'

  def self.included(base)
    base.const_set 'GIT_HASH', commit_hash
    base.const_set 'GIT_BRANCH', branch_name
    base.const_set 'PSAMS_VERSION', '0.5'
  end

  private
  def self.branch_name
    branch_info = `cd #{File.dirname(__FILE__)}/../ && git branch`
    branch_info =~ /^*\s*(.*)$/
    $1
  end
  def self.commit_hash
    branch_info = `cd #{File.dirname(__FILE__)}/../ && git show HEAD`
    branch_info =~ /^commit\s+(.*)$/
    $1
  end

end
