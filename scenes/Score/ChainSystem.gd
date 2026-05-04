class_name ChainSystem

var chain_count: int = 0
var max_chain: int = 4

# 👇 thêm biến này
var chain_mult: float = 1.0

func reset():
	chain_count = 0
	chain_mult = 1.0

func apply_chain(is_valid: bool) -> Dictionary:
	var result = {
		"applied": false,
		"chain_count": chain_count,
		"chain_mult": chain_mult,
		"delta_mult": 1.0
	}

	if is_valid:
		chain_count += 1
		chain_count = min(chain_count, max_chain)

		if chain_count > 1:
			var delta = 1.5
			chain_mult *= delta

			result.applied = true
			result.delta_mult = delta
	else:
		reset()

	result.chain_count = chain_count
	result.chain_mult = chain_mult

	return result

func get_chain_count() -> int:
	return chain_count
