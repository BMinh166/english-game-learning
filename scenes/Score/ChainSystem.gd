class_name ChainSystem

var chain_count: int = 0
var max_chain: int = 9999

# 👇 thêm biến này
var chain_mult: float = 1.0

func reset():
	chain_count = 0
	chain_mult = 1.0

func apply_chain(
		is_valid: bool
	):

	var result = {
		"applied": false,
		"chain_count": chain_count,
		"chain_mult": chain_mult,
		"delta_mult": 1.0
	}

	if is_valid:

		# 👇 chỉ từ valid THỨ 2 mới bắt đầu chain
		if chain_count >= 1:

			var delta = 1.5

			chain_mult *= delta

			result.applied = true
			result.delta_mult = delta

		chain_count += 1
		chain_count = min(chain_count, max_chain)

	else:

		reset()

	result.chain_count = chain_count
	result.chain_mult = chain_mult

	return result

func get_chain_count() -> int:
	return chain_count
