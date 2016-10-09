--Cursed Twin Dolls
function c511000120.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000120.cointg)
	e1:SetOperation(c511000120.coinop)
	c:RegisterEffect(e1)
end
function c511000120.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511000120.cfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end
function c511000120.rmtarget1(e,c)
	return e:GetHandler():GetOwner()==c:GetControler() and not c:IsType(TYPE_MONSTER)
end
function c511000120.rmtarget2(e,c)
	return e:GetHandler():GetOwner()~=c:GetControler() and not c:IsType(TYPE_MONSTER)
end
function c511000120.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local op=Duel.SelectOption(1-tp,aux.Stringid(511000321,0),aux.Stringid(511000321,1))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000120,2))
	local coin=Duel.SelectOption(1-tp,60,61)
	local res=Duel.TossCoin(1-tp,1)
	if (coin~=res and op==0) or (coin==res and op==1) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetRange(LOCATION_SZONE)
		e1:SetOperation(c511000120.recop1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local g=Duel.GetMatchingGroup(c511000120.cfilter,tp,LOCATION_GRAVE,0,nil)
		Duel.Remove(g,POS_FACEUP,REASON_COST)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
		e2:SetRange(LOCATION_SZONE)
		e2:SetTarget(c511000120.rmtarget1)
		e2:SetValue(LOCATION_REMOVED)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
		e3:SetRange(LOCATION_SZONE)
		e3:SetCondition(c511000120.con1)
		e3:SetOperation(c511000120.op1)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
	else
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetRange(LOCATION_SZONE)
		e1:SetOperation(c511000120.recop2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		--remove
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
		e2:SetRange(LOCATION_SZONE)
		e2:SetTarget(c511000120.rmtarget2)
		e2:SetValue(LOCATION_REMOVED)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
		e3:SetRange(LOCATION_SZONE)
		e3:SetCondition(c511000120.con2)
		e3:SetOperation(c511000120.op2)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		local g=Duel.GetMatchingGroup(c511000120.cfilter,1-tp,LOCATION_GRAVE,0,nil)
		Duel.Remove(g,POS_FACEUP,REASON_COST)
	end
end
function c511000120.filter1(c,tp)
	return c:GetOwner()==1-tp
end
function c511000120.recop1(e,tp,eg,ep,ev,re,r,rp)
	local d1=eg:FilterCount(c511000120.filter1,nil,tp)*200
	Duel.Recover(1-tp,d1,REASON_EFFECT)
end
function c511000120.filter2(c,tp)
	return c:GetOwner()==tp
end
function c511000120.recop2(e,tp,eg,ep,ev,re,r,rp)
	local d1=eg:FilterCount(c511000120.filter2,nil,tp)*200
	Duel.Recover(tp,d1,REASON_EFFECT)
end
function c511000120.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c511000120.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0,nil)==0
end
function c511000120.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectYesNo(tp,aux.Stringid(511000120,3)) then
		local g=Duel.SelectMatchingCard(tp,c511000120.filter,tp,LOCATION_GRAVE,0,1,5,nil)
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_TRIGGER)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_UNRELEASABLE_SUM)
			e3:SetValue(1)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3,true)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e4,true)
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE)
			e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e5:SetValue(LOCATION_REMOVED)
			e5:SetReset(RESET_EVENT+0x7e0000)
			tc:RegisterEffect(e5)
			local e6=Effect.CreateEffect(c)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e6:SetValue(1)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e6)
			local e7=Effect.CreateEffect(c)
			e7:SetType(EFFECT_TYPE_SINGLE)
			e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
			e7:SetValue(1)
			tc:RegisterEffect(e7)
			local e8=Effect.CreateEffect(c)
			e8:SetType(EFFECT_TYPE_SINGLE)
			e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e8:SetRange(LOCATION_MZONE)
			e8:SetCode(EFFECT_IMMUNE_EFFECT)
			e8:SetReset(RESET_EVENT+0x1fe0000)
			e8:SetValue(1)
			tc:RegisterEffect(e8)
			tc=g:GetNext()
		end
	end
end
function c511000120.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0,nil)==0
end
function c511000120.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectYesNo(1-tp,aux.Stringid(511000120,3)) then
		local g=Duel.SelectMatchingCard(1-tp,c511000120.filter,1-tp,LOCATION_GRAVE,0,1,5,nil)
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,1-tp,1-tp,LOCATION_MZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_TRIGGER)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_UNRELEASABLE_SUM)
			e3:SetValue(1)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e3,true)
			local e4=e3:Clone()
			e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e4,true)
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE)
			e5:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e5:SetValue(LOCATION_REMOVED)
			e5:SetReset(RESET_EVENT+0x7e0000)
			tc:RegisterEffect(e5)
			local e6=Effect.CreateEffect(c)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e6:SetValue(1)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e6)
			local e7=Effect.CreateEffect(c)
			e7:SetType(EFFECT_TYPE_SINGLE)
			e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
			e7:SetValue(1)
			tc:RegisterEffect(e7)
			local e8=Effect.CreateEffect(c)
			e8:SetType(EFFECT_TYPE_SINGLE)
			e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e8:SetRange(LOCATION_MZONE)
			e8:SetCode(EFFECT_IMMUNE_EFFECT)
			e8:SetReset(RESET_EVENT+0x1fe0000)
			e8:SetValue(1)
			tc:RegisterEffect(e8)
			tc=g:GetNext()
		end
	end
end