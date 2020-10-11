--SCP基金会
function c798654324.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c798654324.attg)
	e1:SetOperation(c798654324.atop)
	c:RegisterEffect(e1)	
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x8a79))
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	local e22=Effect.CreateEffect(c)
	e22:SetType(EFFECT_TYPE_SINGLE)
	e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e22:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e22:SetRange(LOCATION_FZONE)
	e22:SetCondition(c798654324.indcon)
	e22:SetValue(1)
	c:RegisterEffect(e22)
	local e33=e22:Clone()
	e33:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e33)
end
function c798654324.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RACE)
	local rc=Duel.AnnounceRace(tp,1,RACE_ALL)
	e:SetLabel(rc)
end
function c798654324.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetTargetRange(LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(e:GetLabel())
	Duel.RegisterEffect(e1,tp)
end
function c798654324.indfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8a79)
end
function c798654324.indcon(e)
	return Duel.IsExistingMatchingCard(c798654324.indfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end