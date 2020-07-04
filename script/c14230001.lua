local m=14230001
local cm=_G["c"..m]
cm.name="诡秘之主 克莱恩"
function cm.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_SPELLCASTER),2,99,nil)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetOperation(cm.regop)
	e0:SetCondition(cm.regcon)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(cm.atkval)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(cm.tgtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e91=Effect.CreateEffect(c)
	e91:SetType(EFFECT_TYPE_SINGLE)
	e91:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e91:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e91:SetRange(LOCATION_MZONE)
	e91:SetValue(1)
	c:RegisterEffect(e91)
	local e92=Effect.CreateEffect(c)
	e92:SetType(EFFECT_TYPE_SINGLE)
	e92:SetCode(EFFECT_CANNOT_)
	e92:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e92:SetRange(LOCATION_MZONE)
	e92:SetValue(1)
	c:RegisterEffect(e92)
	local e93=Effect.CreateEffect(c)
	e93:SetType(EFFECT_TYPE_SINGLE)
	e93:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e93:SetValue(1)
	c:RegisterEffect(e93)
	local e94=Effect.CreateEffect(c)
	e94:SetType(EFFECT_TYPE_SINGLE)
	e94:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e94:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e94)
end
function cm.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function cm.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end
function cm.atkval(e,c)
	return e:GetHandler():GetLinkedGroup():GetSum(Card.GetBaseAttack)  
end
function cm.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetMaterialCount()>=2 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
		c:RegisterEffect(e1)
	end
		if c:GetMaterialCount()>=3 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(m,1))
		e1:SetCategory(CATEGORY_REMOVE)
		e1:SetType(EFFECT_TYPE_IGNITION)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetTarget(cm.retg2)
		e1:SetOperation(cm.reop2)
		c:RegisterEffect(e1)
	end
		if c:GetMaterialCount()>=4 then
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(m,0))
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCountLimit(1)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		e2:SetOperation(cm.ctop2)
		c:RegisterEffect(e2)
	end
end
function cm.refilter(c)
	return c:IsAbleToRemove()
end
function cm.retg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and cm.refilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(cm.refilter,1-tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,cm.refilter,1-tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function cm.reop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCode(EFFECT_DISABLE)
	tc:RegisterEffect(e1)
end
function cm.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local preatk=c:GetAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-2000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	if preatk~=0 and c:IsAttack(0) then
		Duel.Destroy(c,REASON_EFFECT)
	end
	Duel.SetChainLimit(aux.FALSE)
end