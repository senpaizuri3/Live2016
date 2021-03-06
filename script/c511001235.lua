--Brain Dragon
function c511001235.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001235,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetCondition(c511001235.drcon)
	e1:SetTarget(c511001235.drtg)
	e1:SetOperation(c511001235.drop)
	c:RegisterEffect(e1)
end
function c511001235.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511001235.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c511001235.drop(e,tp,eg,ep,ev,re,r,rp,c)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToDeck,p,LOCATION_HAND,0,2,2,nil)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	Duel.SortDecktop(p,p,2)
end
