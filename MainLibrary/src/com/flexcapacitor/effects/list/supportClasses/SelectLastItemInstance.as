

package com.flexcapacitor.effects.list.supportClasses {
	
	import com.flexcapacitor.effects.list.SelectLastItem;
	import com.flexcapacitor.effects.supportClasses.ActionEffectInstance;
	
	import flash.events.Event;
	
	import spark.components.supportClasses.ListBase;
	

	/**
	 * @copy SelectLastItem
	 * */  
	public class SelectLastItemInstance extends ActionEffectInstance {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 *
		 *  @param target This argument is ignored by the effect.
		 *  It is included for consistency with other effects.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function SelectLastItemInstance(target:Object) {
			super(target);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 * */
		override public function play():void {
			super.play(); // dispatch startEffect
			
			var action:SelectLastItem = SelectLastItem(effect);
			// we were checking for ListBase but DataGrid doesn't use ListBase so list is an object
			var list:Object = target;
			
			///////////////////////////////////////////////////////////
			// Verify we have everything we need before going forward
			///////////////////////////////////////////////////////////
			
			if (validate) {
				if (list==null) {
					dispatchErrorEvent("The target must be set to a list or datagrid type of component.");
				}
				
				if (!list.hasOwnProperty("dataProvider")) {
					dispatchErrorEvent("The list must have a dataProvider property");
				}
				
				if (list.dataProvider==null) {
					dispatchErrorEvent("The list data provider is not set");
				}
			}
			
			///////////////////////////////////////////////////////////
			// Continue with action
			///////////////////////////////////////////////////////////
			
			// no items in the data provider
			if (!list.dataProvider.length==0) { 
				
				if (action.hasEventListener(SelectLastItem.NO_ITEMS)) {
					action.dispatchEvent(new Event(SelectLastItem.NO_ITEMS));
				}
				
				if (action.noItemsEffect) { 
					playEffect(action.noItemsEffect);
				}
				
			}
			else {
				list.selectedIndex = list.dataProvider.length-1;
				action.data = list.selectedItem;
				action.dataIndex = list.selectedIndex;
			}
			
			///////////////////////////////////////////////////////////
			// Finish the effect
			///////////////////////////////////////////////////////////
			
			finish();
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
	}
	
	
}