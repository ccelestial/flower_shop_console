class BestBundle
  def get bundle_quantities, order_quantity
    combination_sum(bundle_quantities, order_quantity).last
  end

  private

  # CREDITS:
  # https://leetcode.com/problems/combination-sum/
  def combination_sum(candidates, target)
    [].tap do |result|
      _combination_sum_(candidates.sort, 0, candidates.size - 1, target, [], result)
    end
  end

  private def _combination_sum_(nums, lbound, ubound, target, tracing, result)
    sum = tracing.reduce(0, &:+)
    nums[lbound..ubound].each_with_index do |n, i|
      break if sum + n > target

      result << (tracing.dup << n) if sum + n == target
      _combination_sum_(nums, lbound + i, ubound, target, tracing.dup << n, result)
    end
  end
end
