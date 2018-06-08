class JiraField < Field
  CACHED_TIME = 1.minute

  validate :validate_structure

  def validate_structure
    errors.add :contents if contents['issue_id'].blank?
  end

  def cached?
    cached_at.present?
  end

  def cached_at
    contents['cached_at']
  end

  def has_to_sync?
    return true unless cached?

    cached_at < Time.current - CACHED_TIME
  end
end
