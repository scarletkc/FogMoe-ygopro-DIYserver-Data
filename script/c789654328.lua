--SCP-053
function c789654328.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,789654320,aux.FilterBoolFunction(Card.IsRace,RACE_FAIRY),1,true,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetCondition(c789654328.condition)
	e4:SetTarget(c789654328.target)
	e4:SetOperation(c789654328.operation)
	c:RegisterEffect(e4)
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_FIELD)
	e22:SetRange(LOCATION_MZONE)
	e22:SetTargetRange(0,LOCATION_MZONE)
	e22:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e22:SetCondition(c789654328.tgcon)
	e22:SetValue(c789654328.atlimit)
	c:RegisterEffect(e22)
end
function c789654328.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsSummonType(SUMMON_TYPE_SPECIAL) and c:GetBaseAttack()~=bc:GetBaseAttack()
end
function c789654328.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc:IsRelateToBattle() end
	local atk=math.abs(e:GetHandler():GetBaseAttack()-bc:GetBaseAttack())
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c789654328.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetFirstTarget()
	local atk=math.abs(e:GetHandler():GetBaseAttack()-bc:GetBaseAttack())
	if bc:IsRelateToEffect(e) and bc:IsFaceup() and Duel.Damage(1-tp,atk,REASON_EFFECT)~=0 then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c789654328.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c789654328.atlimit(e,c)
	return c~=e:GetHandler()
end