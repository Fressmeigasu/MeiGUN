extends LimboHSM


@onready var hsm: LimboHSM = $LimboHSM
@onready var boss_idle_state = $BossIdleState
@onready var boss_attack_state = $BossAttackState
@onready var boss_ultimate_state = $BossUltimateState




func _ready() -> void:
	_init_state_machine()


func _init_state_machine() -> void:
	hsm.add_transition(boss_idle_state, boss_attack_state, boss_idle_state.EVENT_FINISHED)
	hsm.add_transition(boss_attack_state, boss_idle_state, boss_attack_state.EVENT_FINISHED)

	hsm.initialize(self)
	hsm.set_active(true)
