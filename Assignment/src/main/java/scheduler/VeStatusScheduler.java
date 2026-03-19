package scheduler;

import dal.VeDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Scheduler tự động cập nhật trạng thái vé mỗi 24 giờ.
 * Đăng ký trong web.xml qua thẻ <listener>.
 *
 * Trạng thái được cập nhật:
 *   - NgayHetHan < NOW  → "Da het han"
 *   - NgayHetHan >= NOW → "Dang su dung"
 */
public class VeStatusScheduler implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();

        Runnable task = () -> {
            System.out.println("[VeStatusScheduler] Đang cập nhật trạng thái vé...");
            try {
                VeDAO veDAO = new VeDAO();
                int updated = veDAO.capNhatTrangThaiVe();
                System.out.println("[VeStatusScheduler] Đã cập nhật " + updated + " vé.");
            } catch (Exception e) {
                System.err.println("[VeStatusScheduler] Lỗi khi cập nhật trạng thái vé: " + e.getMessage());
                e.printStackTrace();
            }
        };

        // Chạy ngay khi khởi động (delay = 0), sau đó mỗi 24 giờ
        scheduler.scheduleAtFixedRate(task, 0, 24, TimeUnit.HOURS);
        System.out.println("[VeStatusScheduler] Scheduler đã được khởi động, chạy mỗi 24 giờ.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            System.out.println("[VeStatusScheduler] Scheduler đã được dừng.");
        }
    }
}
