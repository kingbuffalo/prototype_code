package com.lehu.framework {
	import com.lehu.framework.datapool.DataPoolMgr;
	import com.lehu.framework.datapool.interfaces.IDataPoolMgr;
	import com.lehu.framework.net.CmdVO;
	import com.lehu.framework.net.LHRecCmdMgr;
	import com.lehu.framework.view.interfaces.IViewMgr;
	import com.lehu.framework.view.ViewMgr;
	import com.lehu.game.modules.controllBtn.view.BtnView;
	import com.lehu.game.modules.cursor.datapool.CursorDP;
	import com.lehu.game.modules.cursor.view.CursorV;
	import com.lehu.game.modules.deco.view.DecoV;
	import com.lehu.game.modules.deco.win.DecoUWin;
	import com.lehu.game.modules.elves.datapool.ElvesDP;
	import com.lehu.game.modules.elves.win.ArenaUWin;
	import com.lehu.game.modules.others.HeadUrlDP;
	import com.lehu.game.net.cmdvo.cmdGetMapNPCStatus.CmdGetMapNPCStatusVO;
	import com.lehu.game.modules.elves.view.BattleMovieV;
	//import com.lehu.game.modules.elves.view.PlotView;
	import com.lehu.game.modules.elves.win.AreaFBUIWin;
	import com.lehu.game.modules.elves.win.ElvesActiveUWin;
	import com.lehu.game.modules.elves.win.ElvesLvUpUWin;
	import com.lehu.game.modules.elves.win.ElvesPicInfoUWin;
	import com.lehu.game.modules.elves.win.ElvesPicUWin;
	import com.lehu.game.net.cmdvo.cmd_fightNPC.CmdFightNPCVO;
	import com.lehu.game.net.cmdvo.cmdGetElvesList.CmdGetElvesList;
	import com.lehu.game.net.cmdvo.cmdGetElvesSeatList.CmdGetElvesSeatListVO;
	import com.lehu.game.net.cmdvo.cmdgetweaponlist.CmdGetWeaponListVO;
	import com.lehu.game.net.cmdvo.cmd_getElvesQueue.CmdGetElvesQueueVO;
	import com.lehu.game.modules.elves.win.ElvesGradeUpUWin;
	import com.lehu.game.net.cmdvo.*;
	import com.lehu.game.net.cmdvo.cmd_arena.*;
	//import com.lehu.game.modules.elves.win.SoulComposeUWin;
	//import com.lehu.game.modules.elves.win.WinFBUIWin;
	import com.lehu.game.modules.fishbag.datapool.FishBagDP;
	import com.lehu.game.modules.fishbag.view.FishBagV;
	import com.lehu.game.modules.fishpond.datapool.FishPondDP;
	import com.lehu.game.modules.fishpond.view.FireworkV;
	import com.lehu.game.modules.fishpond.view.FishPondV;
	import com.lehu.game.modules.formation.win.SetFormatIndexUWin;
	import com.lehu.game.modules.friendList.datapool.FriendListDataPool;
	import com.lehu.game.modules.friendList.view.FriendListView;
	import com.lehu.game.modules.gift.win.GiftUW;
	import com.lehu.game.modules.loadRes.view.LoadingResView;
	import com.lehu.game.modules.main.datapool.GameDataPool;
	import com.lehu.game.modules.main.view.GameView;
	import com.lehu.game.modules.main.view.NewPlayerV;
	import com.lehu.game.modules.message.datapool.MessageDP;
	import com.lehu.game.modules.message.win.MessageUWin;
	import com.lehu.game.modules.weapon.win.WeaponInfoUWin;
	import com.lehu.game.modules.weapon.win.WeaponLvupUWin;
	import com.lehu.game.modules.weapon.win.WeaponGradeUpUW;
	import com.lehu.game.modules.weapon.win.WeaponListUWin;
	import com.lehu.game.modules.others.InitMgr;
	import com.lehu.game.modules.pic.datapool.PicDP;
	import com.lehu.game.modules.pic.win.PicInfoUWin;
	import com.lehu.game.modules.pic.win.PicUWin;
	import com.lehu.game.modules.shop.datapool.ShopDP;
	import com.lehu.game.modules.shop.win.BuyItemUWin;
	import com.lehu.game.modules.shop.win.ShopUWin;
	import com.lehu.game.modules.ware.datapool.WareDP;
	import com.lehu.game.modules.ware.win.WareUWin;
	import com.lehu.game.modules.window.alert.view.AlertWin;
	import com.lehu.game.net.cmdvo.askphotolist.CmdAskPhotoListVO;
	import com.lehu.game.net.cmdvo.cmd_ask_fishPic.CmdAskFishPic;
	import com.lehu.game.net.cmdvo.cmdaskbaglist.CmdAskFishInven;
	import com.lehu.game.net.cmdvo.cmdAskFishIBList.CmdAskFishIBListVO;
	import com.lehu.game.net.cmdvo.cmdAskFishMsg.CmdAskFishMsgVO;
	import com.lehu.game.net.cmdvo.cmdaskfishware.CmdAskFishWareVO;
	import com.lehu.game.net.cmdvo.cmdgetfishfriends.CmdGetFishFriendsVO;
	import com.lehu.game.net.cmdvo.cmdGetFishShopBuyCountList.CmdGetFishShopBuyCountListVO;
	import com.lehu.game.net.cmdvo.cmdRefreshFist.CmdRefreshFishVO;
	import com.lehu.game.net.cmdvo.cmdRefreshMine.CmdRefreshMineVO;
	import com.lehu.game.net.cmdvo.innerCmdvo.CmdCursorVO;
	import com.lehu.game.net.cmdvo.innerCmdvo.InnerCmdDrawGiftVO;
	import com.lehu.game.net.cmdvo.innerCmdvo.LoadResCmdVO;
	import com.lehu.game.net.cmdvo.login.CmdLoginVO;
	import com.lehu.game.net.LHCmd;
	import com.lehu.game.net.LHInnerCmd;
	import com.lehu.game.resource.LHResourceMgr;
	import com.lehu.game.staticTable.AllStaticTable;
	
	/**
	 * ...
	 * @author boy
	 */
	public class FrameworkStartUp {
		private static var _instance:FrameworkStartUp;
		
		private var _dataPoolMgr:IDataPoolMgr;
		private var _viewMgr:IViewMgr;
		
		public function FrameworkStartUp(main:Main) {
			if (_instance != null) {
				throw(new Error("FrameworkStartUp_single_error"));
			}
			init(main);
		}
		
		public static function getInstance(main:Main = null):FrameworkStartUp {
			if (_instance == null) {
				_instance = new FrameworkStartUp(main);
			}
			return _instance;
		}
		
		public function startUp():void {
			initView();
			initDataPool();
			initCmd();
			InitMgr.instance.startInitStep();
		}
		
		private function init(main:Main):void {
			_viewMgr = ViewMgr.instance;
			_viewMgr.registeViewInstance(GameView.noteArr,GameView.instance);
			GameView.instance.initMain(main);
		}
		
		private function initView():void {
			//return;
			_viewMgr.registeView(LoadingResView.NAME, LoadingResView.noteArr, LoadingResView);
			_viewMgr.registeView(CursorV.NAME, CursorV.noteArr, CursorV);
			_viewMgr.registeView(FishBagV.NAME, FishBagV.noteArr, FishBagV);
			_viewMgr.registeView(FishPondV.NAME, FishPondV.noteArr, FishPondV);
			_viewMgr.registeView(FriendListView.NAME, FriendListView.noteArr, FriendListView);
			_viewMgr.registeView(FireworkV.NAME, FireworkV.noteArr, FireworkV);
			_viewMgr.registeView(DecoV.NAME, DecoV.noteArr, DecoV);
			_viewMgr.registeView(BattleMovieV.NAME, BattleMovieV.noteArr, BattleMovieV);
			_viewMgr.registeView(BtnView.NAME, BtnView.noteArr, BtnView);
			//_viewMgr.registeView(PlotView.NAME, PlotView.noteArr, PlotView);
			
			//windows
			_viewMgr.registeView(ShopUWin.NAME, ShopUWin.noteArr, ShopUWin);
			_viewMgr.registeView(PicUWin.NAME, PicUWin.noteArr, PicUWin);
			_viewMgr.registeView(PicInfoUWin.NAME, PicInfoUWin.noteArr, PicInfoUWin);
			_viewMgr.registeView(AlertWin.NAME, AlertWin.noteArr, AlertWin);
			_viewMgr.registeView(BuyItemUWin.NAME, BuyItemUWin.noteArr, BuyItemUWin);
			_viewMgr.registeView(MessageUWin.NAME, MessageUWin.noteArr, MessageUWin);
			_viewMgr.registeView(GiftUW.NAME, GiftUW.noteArr, GiftUW);
			_viewMgr.registeView(NewPlayerV.NAME, NewPlayerV.noteArr, NewPlayerV);
			_viewMgr.registeView(WareUWin.NAME, WareUWin.noteArr, WareUWin);
			_viewMgr.registeView(DecoUWin.NAME, DecoUWin.noteArr, DecoUWin);
			_viewMgr.registeView(SetFormatIndexUWin.NAME, SetFormatIndexUWin.noteArr, SetFormatIndexUWin);
			_viewMgr.registeView(AreaFBUIWin.NAME, AreaFBUIWin.noteArr, AreaFBUIWin);
			//_viewMgr.registeView(WinFBUIWin.NAME, WinFBUIWin.noteArr, WinFBUIWin);
			_viewMgr.registeView(ElvesPicUWin.NAME, ElvesPicUWin.noteArr, ElvesPicUWin);
			_viewMgr.registeView(ElvesActiveUWin.NAME, ElvesActiveUWin.noteArr, ElvesActiveUWin);
			_viewMgr.registeView(ElvesLvUpUWin.NAME, ElvesLvUpUWin.noteArr, ElvesLvUpUWin);
			_viewMgr.registeView(ElvesPicInfoUWin.NAME, ElvesPicInfoUWin.noteArr, ElvesPicInfoUWin);
			_viewMgr.registeView(ElvesGradeUpUWin.NAME, ElvesGradeUpUWin.noteArr, ElvesGradeUpUWin);
			_viewMgr.registeView(WeaponInfoUWin.NAME, WeaponInfoUWin.noteArr, WeaponInfoUWin);
			_viewMgr.registeView(WeaponListUWin.NAME, WeaponListUWin.noteArr, WeaponListUWin);
			_viewMgr.registeView(WeaponLvupUWin.NAME, WeaponLvupUWin.noteArr, WeaponLvupUWin);
			_viewMgr.registeView(WeaponGradeUpUW.NAME, WeaponGradeUpUW.noteArr, WeaponGradeUpUW);
			_viewMgr.registeView(ArenaUWin.NAME, ArenaUWin.noteArr, ArenaUWin);
		}
		
		private function initDataPool():void {
			_dataPoolMgr = DataPoolMgr.instance;
			
			_dataPoolMgr.regiestDataPool(LHResourceMgr.instance);
			_dataPoolMgr.regiestDataPool(AllStaticTable.instance);
			_dataPoolMgr.regiestDataPool(GameDataPool.instance);
			_dataPoolMgr.regiestDataPool(PicDP.instance);
			_dataPoolMgr.regiestDataPool(FriendListDataPool.instance);
			
			_dataPoolMgr.regiestDataPool(FishBagDP.instance);
			_dataPoolMgr.regiestDataPool(FishPondDP.instance);
			
			_dataPoolMgr.regiestDataPool(ShopDP.instance);
			
			_dataPoolMgr.regiestDataPool(CursorDP.instance);
			_dataPoolMgr.regiestDataPool(MessageDP.instance);
			_dataPoolMgr.regiestDataPool(WareDP.instance);
			_dataPoolMgr.regiestDataPool(ElvesDP.instance);
			_dataPoolMgr.regiestDataPool(HeadUrlDP.instance);
		}
		
		private function initCmd():void {
			/********************inner cmd***********************/
			LHRecCmdMgr.instance.regiestCmdVO(LHInnerCmd.LOAD_RESOURCE,LoadResCmdVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_static_table, LoadResCmdVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHInnerCmd.SHOW_CURSOR,CmdCursorVO);
			
			/*****************out cmd****************************/
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_login,CmdLoginVO);
			
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_ask_fishPic,CmdAskFishPic);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_lvUp_Pic,CmdLvUpPicVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_refreshFish,CmdRefreshFishVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_session_error,CmdSessionErrorVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_askFishInven,CmdAskFishInven);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_refresh_mine,CmdRefreshMineVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_moveInvFishToSeat,CmdMoveInvFishToSeatVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_levelUpFish,CmdVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_create_fish_bag,CmdCreateFishBagVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_refreshFishBag,CmdRefreshFishBagVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_askFishMsg,CmdAskFishMsgVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_cleanFishMsg,CmdVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_session_error,CmdVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getFishShopBuyCountList,CmdGetFishShopBuyCountListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_buyFishItems,CmdBuyFishItemsVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_harvestFish,CmdHarvestFishVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_moveBagFishToSeat,CmdMoveBagFishToSeat);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getFishFriends,CmdGetFishFriendsVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_stealFish,CmdStealFishVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_openFishGift,CmdOpenFishGiftVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHInnerCmd.DRAW_GIFT,InnerCmdDrawGiftVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_feedFish,CmdFeedFishVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_ask_photoList,CmdAskPhotoListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_accelerateFish,CmdAccelerateFishVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_playFishDIY,CmdPlayFishDIYVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_askFishWare,CmdAskFishWareVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_askFishIBList,CmdAskFishIBListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_changeFishIB,CmdChangeFishIBVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_changeShowSeat,CmdChangeShowSeatVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_playFormat,CmdPlayFormatVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_useInvItemGifts,CmdUseInvItemGiftsVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_weaponActive,CmdWeaponActiveVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getWeaponList,CmdGetWeaponListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_elvesActivation,CmdElvesActivation);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_elvesLevelUp, CmdElvesLevelUp);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_elvesGradeUp,CmdElvesGradeUpVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getElvesList,CmdGetElvesList);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getElvesSeatList,CmdGetElvesSeatListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_adjustElvesSeat,CmdAdjustElvesSeatVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_adjustElvesWeapon,CmdAdjustElvesWeaponVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_decomposeElves,CmdDecomposeElvesVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_sellFishItem,CmdSellFishItemVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getElvesQueue,CmdGetElvesQueueVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_fightNPC,CmdFightNPCVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getMapNPCStatus,CmdGetMapNPCStatusVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getFighterInfo,CmdGetFighterInfoVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_weaponLvUp,CmdWeaponLvUpVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_decomposeWeapon,CmdDecomposeWeaponVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_fishCompose, CmdFishComposeVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_weaponGradeUp, CmdWeaponGradeUpVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_askArenaList, CmdAskArenaListVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_arenaFight, CmdArenaFightVO);
			LHRecCmdMgr.instance.regiestCmdVO(LHCmd.cmd_getArenaAward, CmdGetArenaAwardVO);
		}
	
	}

}
