Trait {
	#name : 'TBindingInteractionModelTrait',
	#instVars : [
		'bindings'
	],
	#classTraits : '{} + TraitedClass',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'accessing' }
TBindingInteractionModelTrait >> addBinding: aBinding [

	self bindings add: aBinding
]

{ #category : 'accessing' }
TBindingInteractionModelTrait >> bindingOf: aString [

	"if there is no binding, I will include a key"
	(self bindings includesKey: aString)
		ifFalse: [ self addBinding: (WorkspaceVariable key: aString asSymbol) ].
	^ self bindings associationAt: aString
]

{ #category : 'accessing' }
TBindingInteractionModelTrait >> bindings [

	^ bindings ifNil: [ bindings := Dictionary new ]
]

{ #category : 'accessing' }
TBindingInteractionModelTrait >> hasBindingOf: aString [

	^ self bindings includesKey: aString asSymbol
]
