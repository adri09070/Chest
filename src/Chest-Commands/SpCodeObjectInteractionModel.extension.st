Extension { #name : 'SpCodeObjectInteractionModel' }

{ #category : '*Chest-Commands' }
SpCodeObjectInteractionModel >> addBinding: aBinding [

	self bindings add: aBinding
]

{ #category : '*Chest-Commands' }
SpCodeObjectInteractionModel >> bindingOf: aString [

	self bindings associationAt: aString ifAbsent: [ nil ]
]

{ #category : '*Chest-Commands' }
SpCodeObjectInteractionModel >> canLoadBindings [

	^ true
]

{ #category : '*Chest-Commands' }
SpCodeObjectInteractionModel >> hasBindingOf: aString [
	"we search the name in the interaction model as we would do in a playground"
	^ self bindings includesKey: aString
]
