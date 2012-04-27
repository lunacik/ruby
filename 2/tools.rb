
#defined constants
MIN_USER_AGE = 14
MIN_WORKER_AGE = 18
MAX_BOOKS_ALLOWED = 5


module AgeRange
  def check_age(birthday, limit)
    birth = birthday.year * 10000 + birthday.month * 100 + birthday.day
    range = (Date.today.year - limit) * 10000 + Date.today.month * 100 + Date.today.day
    if birth > range
      raise "Cannot create user younger than #{limit}"
    end
  end
end



module IDGenerator
  def new_id(ids = nil)
    if ids == nil
      ids = self.class.all.collect {|item| item.id}
    end

    if ids == []
      0
    else
      0.upto(ids.max + 1).find {|id| not ids.include?(id)}
    end
  end
end



