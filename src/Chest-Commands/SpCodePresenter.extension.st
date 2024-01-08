Extension { #name : 'SpCodePresenter' }

{ #category : '*Chest-Commands' }
SpCodePresenter class >> buildChestCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup [
	<extensionCommands>
	ChestCommandTreeBuilder buildCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup 
]

{ #category : '*Chest-Commands' }
SpCodePresenter >> canLoadBindings [

	^ self interactionModel canLoadBindings
]

{ #category : '*Chest-Commands' }
SpCodePresenter >> evaluate: aString onCompileError: compileErrorBlock onError: errorBlock [
	"evaluate aString. 
	 evaluate compileErrorBlock if there are compilation errors. 
	 evaluate errorBlock is anything happens *during* evaluation (code compiled, but it does not 
	 executes.). 
	 NOTE for future me. This is how I understand the evaluation works and why we need to catch 
	 differently the error: If there is a syntax error (avoiding compilation), it will evaluate 
	 requestor>>#notify:at:in: to notify the error and then it will call failBlock: *which is not 
	 intended to be used to throw an error*, since that should be handled (and it is) in the 
	 notification. Instead, most users of failBlock: use it to return execution without doing 
	 anything. 
	 Instead, the on:do: will catch all errors happening while executing the code once it is 
	 compiled. "

	| result oldBindings |
	^ [
	  self announcer announce:
		  (SpCodeWillBeEvaluatedAnnouncement newContent: aString).
	  oldBindings := self interactionModel bindings copy.
	  result := self interactionModel compiler
		            source: aString;
		            environment: self environment;
		            bindings: self interactionModel bindings;
		            failBlock: [
			            self announcer announce:
					            (SpCodeEvaluationFailedAnnouncement newContent:
							             aString).
			            ^ compileErrorBlock value ];
		            evaluate.
	  oldBindings size = self interactionModel bindings size ifFalse: [
		  self withAdapterDo: [ :anAdapter | anAdapter refreshStyling ] ].
	  self announcer announce:
		  (SpCodeEvaluationSucceedAnnouncement newContent: aString).
	  result ]
		  on: Error
		  do: [ :e |
			  self announcer announce:
				  (SpCodeEvaluationFailedAnnouncement newContent: aString error: e).
			  errorBlock value: e ]
]
