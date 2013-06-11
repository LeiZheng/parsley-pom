package org.spicefactory.parsley.command.observer {

import org.spicefactory.parsley.command.trigger.Trigger;
import org.spicefactory.parsley.command.trigger.TriggerA;
import org.spicefactory.parsley.command.trigger.TriggerB;

/**
 * @author Jens Halm
 */
public class CommandObserversMetadata extends CommandObservers {
	
	
	[CommandComplete]
	public override function completeA (trigger: TriggerA) : void {
		super.completeA(trigger);
	}
	
	[CommandComplete]
	public override function completeB (trigger: TriggerB) : void {
		super.completeB(trigger);
	}
	
	[CommandComplete]
	public override function complete (trigger: Trigger) : void {
		super.complete(trigger);
	}
	
	[CommandResult(immediate="true")]
	override public function resultA (result: Object, trigger: TriggerA) : void {
		super.resultA(result, trigger);
	}
	
	[CommandResult(immediate="true")]
	public override function resultB (result: Object, trigger: TriggerB) : void {
		super.resultB(result, trigger);
	}
	
	[CommandResult(immediate="true")]
	public override function result (result: Object, trigger: Trigger) : void {
		super.result(result, trigger);
	}
	
	[CommandError(immediate="true")]
	public override function error (result:Object, trigger: Trigger) : void {
		super.error(result, trigger);
	}
}
}
